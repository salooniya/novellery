import { View, $, Router } from 'farmy';
import app from '../app.fy';
import * as NovelModel from '../models/novelModel.fy';
import * as UserModel from '../models/userModel.fy';
import * as ChapterModel from '../models/chapterModel.fy';

const headerView = new View(/*html*/`
    <header>
        <h1><a href="/">[appName]</a></h1>
        <nav>
            [user-nav-1]
            [user-nav-2]
        </nav>
    </header>
`);

const novelsView = new View(/*html*/`
    ${headerView.template}
    <section class="novels-view">
        <h2>📚 Novels</h2>
        <hr>
        <div class="list">
            [novels]
            (<div class="list-item">
                <h3><a href="/novels/[ID]">[ID]</a></h3>
                <p>title: [title]</p>
                <p>authorID: [authorID]</p>
                <p>ratings: [ratings]</p>
                <p>subscribers: [subscribers]</p>
                <p>genrePrimary: [genrePrimary]</p>
                <p>genreSecondary: [genreSecondary]</p>
                <p>chaptersID: [chaptersID]</p>
            </div>)
        </div>
    </section>
`);

export const novels = async function () {
    const user = await app:db.index.get('user');
    const novels = await NovelModel.getAll();
    console.log(novels);

    const view = novelsView.get({
        appName: app:name,
        'user-nav-1': user ? `<a href="/users/${user.ID}">🙍‍♂️ USER</a>` : `<a href="/signup">😄 SIGNUP</a>`,
        'user-nav-2': user ? `` : `<a href="/login">😃 LOGIN</a>`,
        novels
    });
    app:root.innerHTML(view);
};

const novelView = new View(/*html*/`
    ${headerView.template}
    <section class="novel-view">
        <div class="flex-row">
            <h2>📘 [title]</h2>
            <button class="left-margin [isSubscribed]">[isSubscribed]</button>
        </div>
        <hr>
        <div class="text-box">
            <a href="/authors/[authorID]">✍ [author]</a>
            <p>⭐ [ratings]</p>
            <p>👥 [subscribers]</p>
            <p>🧬 [genrePrimary], [genreSecondary]</p>
        </div>
        <div class="flex-row">
            <h2>📖 Chapters</h2>
        </div>
        <hr>
        <div class="text-box">
            [chapters]
            (<a href="/chapters/[ID]">📄 [chapterTitle]</a><br>)
        </div>
    </section>
`);

export const novelByID = async function (req) {
    let user = await app:db.index.get('user');
    let novel = await NovelModel.getOne(req.params.novelID);
    console.log(novel);
    console.log(user);

    const chapters = [];
    for (const chapterID of novel.chaptersID) {
        const chapter = await ChapterModel.getOne(chapterID);
        chapters.push(chapter);
    }

    const author = (await UserModel.getOne(novel.authorID)).fullname;

    const view = novelView.get({
        appName: app:name,
        'user-nav-1': user ? `<a href="/users/${user.ID}">🙍‍♂️ USER</a>` : `<a href="/signup">😄 SIGNUP</a>`,
        'user-nav-2': user ? `` : `<a href="/login">😃 LOGIN</a>`,
        isSubscribed: user.subscribedNovelsID.includes(novel.ID) ? 'unsubscribe' : 'subscribe',
        chapters,
        author,
        ... novel
    });
    app:root.innerHTML(view);

    const $novelView = $('section.novel-view');
    $novelView.$('.subscribe').on('click', async function () {
        await UserModel.subscribeNovel(user.ID, novel.ID);
        app:router.run();
    });
    $novelView.$('.unsubscribe').on('click', async function () {
        await UserModel.unsubscribeNovel(user.ID, novel.ID);
        app:router.run();
    });
};

export const novelChapters = async function () {

};

export const novelChapterByID = async function () {

};
