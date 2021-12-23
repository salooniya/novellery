import { State, Router, $ } from "farmy";

// functions
const updateTitle = function () {
    $.title( app:title );
};

const updateDescription = function () {
    $.description( app:description );
};

// app state
const app = new State();

// initialization
let String app:name = undefined;
let String app:title = undefined;
let String app:description = undefined;
let $.List app:root = undefined;
let Router app:router = undefined;
let State.LocalDB app:db = undefined;

// actions
app::title @ updateTitle = updateTitle;
app::title @ updateDescription = updateDescription;

// declaration
app:name = 'Novellery';
app:title = app:name;
app:description = 'Powered by farmy';
app:root = $('#root');
app:router = new Router();
app:db = new State.LocalDB(app:name);

// router
app:router ENV browser;

// db
app:db.users = app:db.collection('users');
app:db.novels = app:db.collection('novels');
app:db.chapters = app:db.collection('chapters');
app:db.index = app:db.collection('index');

export default app;
