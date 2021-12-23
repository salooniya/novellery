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

    // const novels = await NovelModel.getAll();
    // const users = await getAll();

    // for (let i = 0; i < 10; i++) {
    //     const user = users[random(0, 9)];
    //     const novel = novels[random(0, 19)];
    //     user.subscribedNovelsID.push(novel.ID);
    // }

    // app:db.save();

    // for (let i = 0; i < n; i++) {
    //     await app:db.users.create({
    //         username: `username${i}`,
    //         fullname: `User ${i}`,
    //         email: `username${i}@gmail.com`,
    //         password: `username${i}`,
    //         subscribedNovels: [],
    //         gender: randomSelect(['male', 'female', 'other'])
    //     });
    // }

    // app:db.save();
};

export const getAll = async function () {
    return Object.values(app:db.users.data);
};

export const getOne = async function (ID) {
    const doc = await app:db.users.get(ID);
    return doc;
};

export const getOneByUsername = async function (username) {
    const users = await getAll();
    return users.find(u => u.username === username);
};

export const postOne = async function (user) {
    const doc = await app:db.users.create(user);
    app:db.save();
    return doc;
};

export const putOne = async function (ID, user) {
    const doc = await app:db.users.update(ID, user, true);
    app:db.save();
    return doc;
};

export const patchOne = async function (ID, update) {
    const doc = await app:db.users.update(ID, update);
    app:db.save();
    return doc;
};

export const deleteOne = async function (ID) {
    const doc = await app:db.users.delete(ID);
    app:db.save();
    return doc;
};

export const subscribeNovel = async function (userID, novelID) {
    const user = await app:db.users.get(userID);
    user.subscribedNovels.unshift(novelID);
    app:db.save();
    return user;
};

export const unsubscribeNovel = async function (userID, novelID) {
    const user = await app:db.users.get(userID);
    const indexOfNovelID = user.subscribedNovels.indexOf(novelID);
    user.subscribedNovels.splice(indexOfNovelID, 1);
    app:db.save();
    return user;
};

export const login = async function (username, password) {
    const user = await getOneByUsername(username);
    if (!user) return;
    if (user.password !== password) return;
    await app:db.index.set('user', user);
    app:db.save();
    return user;
};

export const logout = async function () {
    await app:db.index.set('user', undefined);
    app:db.save();
    return true;
};
