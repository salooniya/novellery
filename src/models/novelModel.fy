import app from "../app.fy";
import * as UserModel from '../models/userModel.fy';

const random = function (start, end) {
    return start + Math.floor(Math.random()*(end-start+1));
};

const randomSelect = function (arr) {
    const n = random(0, arr.length -1);
    return arr[n];
};

const fillDB = async function (n) {
    // const authorList = ['Syra Tinker', 'Lioness', 'Perth William', 'J.Balvin', 'John Tyler'];
    // const genreList = ['Romance', 'Action', 'Adventure', 'Sci-fi', 'Thriller', 'Horror', 'Biography', 'Mistery', 'Fantasy'];

    // const users = await UserModel.getAll();

    // for (let i = 0; i < n; i++) {
    //     const randomUser = users[random(0, users.length - 1)];
    //     const novel = await app:db.novels.create({
    //         title: `Novel ${i}`,
    //         authorID: randomUser.ID,
    //         subscribers: random(10, 1000),
    //         ratings: random(10, 50)/10,
    //         genrePrimary: randomSelect(genreList),
    //         genreSecondary: randomSelect(genreList),
    //         chaptersID: []
    //     });
    //     if (randomUser.createdNovelsID) randomUser.createdNovelsID.push(novel.ID);
    //     else randomUser.createdNovelsID = [novel.ID];
    // }

    // app:db.save();
};

export const getAll = async function () {
    return Object.values(app:db.novels.data);
};

export const getOne = async function (ID) {
    const doc = await app:db.novels.get(ID);
    return doc;
};

export const post = async function (novel) {
    const doc = await app:db.novels.create(novel);
    app:db.save();
    return doc;
};

export const putOne = async function (ID, novel) {
    const doc = await app:db.novels.update(ID, novel, true);
    app:db.save();
    return doc;
};

export const patchOne = async function (ID, update) {
    const doc = await app:db.novels.update(ID, update);
    app:db.save();
    return doc;
};

export const deleteOne = async function (ID) {
    const doc = await app:db.novels.delete(ID);
    app:db.save();
    return doc;
};
