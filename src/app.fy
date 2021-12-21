import { State, Router, Component, View, $ } from 'farmy';
import NovelRouter from './routers/novel';
import AppRouter from './routers/app';

// create app state
const app = new State();

// initialization
let String app:name = undefined;
let String app:title = undefined;
let String app:description = undefined;
let $.List app:root = undefined;
let Router app:router = undefined;
let State.LocalDB app:db = undefined;

// actions
app::title @ updateTitle = () => { $.title( app:title ) };
app::description @ updateDescription = () => { $.description( app:description ) };

// declaration
app:name = 'Novellery';
app:title = app:name;
app:description = 'A web app to read what you love';
app:root = $('#root');
app:router = new Router();
app:db = new State.LocalDB(app:name);

// create localDB collections
app:db.novels = app:db.collection('novels');
app:db.chapters = app:db.collection('chapters');
app:db.users = app:db.collection('users');

import NovelRouter from './routers/novel';
import AppRouter from './routers/app';

// create router routes
app:router.route('/novels', NovelRouter);
app:router.route('/', AppRouter);

// run router
app:router.run();

export default app;
