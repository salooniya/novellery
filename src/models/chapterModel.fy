import app from "../app.fy";
import * as NovelModel from '../models/novelModel.fy';

const random = function (start, end) {
    return start + Math.floor(Math.random()*(end-start+1));
};

const randomSelect = function (arr) {
    const n = random(0, arr.length -1);
    return arr[n];
};

const fillDB = async function (n) {

    const novels = await NovelModel.getAll();

    for (let i = 0; i < n; i++) {
        const novel = novels[random(0, novels.length - 1)];
        const chapter = await app:db.chapters.create({
            chapterTitle: `Chapter ${i}`,
            novelID: novel.ID,
            likes: random(10, 1000),
            body: 'So this is a tale of ...'
        });
        novel.chaptersID.push(chapter.ID);
    }

    app:db.save();
};

export const getAll = async function () {
    return Object.values(app:db.chapters.data);
};

export const getOne = async function (ID) {
    const doc = await app:db.chapters.get(ID);
    return doc;
};

export const post = async function (chapter) {
    const doc = await app:db.chapters.create(chapter);
    app:db.save();
    return doc;
};

export const putOne = async function (ID, chapter) {
    const doc = await app:db.chapters.update(ID, chapter, true);
    app:db.save();
    return doc;
};

export const patchOne = async function (ID, update) {
    const doc = await app:db.chapters.update(ID, update);
    app:db.save();
    return doc;
};

export const deleteOne = async function (ID) {
    const doc = await app:db.chapters.delete(ID);
    app:db.save();
    return doc;
};
