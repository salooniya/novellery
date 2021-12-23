import './app.sass';
import app from "./app.fy";
import UserRouter from "./routers/userRouter.js";
import AuthorRouter from "./routers/authorRouter.js";
import NovelRouter from "./routers/novelRouter.js";
import ChapterRouter from "./routers/chapterRouter.js";
import IndexRouter from "./routers/indexRouter.js";

// add router routes
app:router.use(async function () {
    let user = await app:db.index.get('user');
    if (user) {
        user = await app:db.users.get(user.ID);
        await app:db.index.set('user', user);
    }
});
app:router.route('/users', UserRouter);
app:router.route('/authors', AuthorRouter);
app:router.route('/novels', NovelRouter);
app:router.route('/chapters', ChapterRouter);
app:router.route('/', IndexRouter);

// run router
app:router.run();
