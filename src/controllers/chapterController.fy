import { View } from 'farmy';
import app from '../app.fy';
import * as ChapterModel from '../models/chapterModel.fy';

const headerView = new View(/*html*/`
    <header>
        <h1><a href="/">[appName]</a></h1>
        <nav>
            <a href="/login">😃 LOGIN</a>
            <a href="/signup">😄 SIGNUP</a>
        </nav>
    </header>
`);

const chaptersView = new View(/*html*/`
    ${headerView.template}
    <section class="chapters-view">
        <h2>📖 Chapters</h2>
        <hr>
        <div class="list">
            [chapters]
            (<div class="list-item">
                <h3><a href="/chapters/[ID]">[ID]</a></h3>
                <p>title: [chapterTitle]</p>
                <p>novelID: [novelID]</p>
                <p>likes: [likes]</p>
                <p>body: [body]</p>
            </div>)
        </div>
    </section>
`);

export const chapters = async function () {
    const chapters = await ChapterModel.getAll();
    console.log(chapters);

    const view = chaptersView.get({
        appName: app:name,
        chapters
    });
    app:root.innerHTML(view);
};

const chapterView = new View(/*html*/`
    ${headerView.template}
    <section class="chapter-view">
        <h2>📄 [chapterTitle]</h2>
        <hr>
        <div class="text-box">
            <p>📘 [novelID]</p>
            <p>🖤 [likes]</p>
            <p>📰 [body]</p>
        </div>
    </section>
`);

export const chapterByID = async function (req) {
    const chapter = await ChapterModel.getOne(req.params.chapterID);
    console.log(chapter);

    const view = chapterView.get({
        appName: app:name,
        ... chapter
    });
    app:root.innerHTML(view);
};
