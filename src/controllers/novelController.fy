import { View } from 'farmy';
import app from '../app.fy';
import * as NovelModel from '../models/novelModel.fy';

const headerView = new View(/*html*/`
    <header>
        <h1><a href="/">[appName]</a></h1>
        <nav>
            <a href="/login">😃 LOGIN</a>
            <a href="/signup">😄 SIGNUP</a>
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
    const novels = await NovelModel.getAll();
    console.log(novels);

    const view = novelsView.get({
        appName: app:name,
        novels
    });
    app:root.innerHTML(view);
};

const novelView = new View(/*html*/`
    ${headerView.template}
    <section class="novel-view">
        <h2>📘 [title]</h2>
        <hr>
        <div class="text-box">
            <p>✍ [authorID]</p>
            <p>⭐ [ratings]</p>
            <p>👥 [subscribers]</p>
            <p>🧬 [genrePrimary], [genreSecondary]</p>
            <p>📖 [chaptersID]</p>
        </div>
    </section>
`);

export const novelByID = async function (req) {
    const novel = await NovelModel.getOne(req.params.novelID);
    console.log(novel);

    const view = novelView.get({
        appName: app:name,
        ... novel
    });
    app:root.innerHTML(view);
};

export const novelChapters = async function () {

};

export const novelChapterByID = async function () {

};
