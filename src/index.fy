import app from './app.fy';
import NovelRouter from './routers/novel';
import IndexRouter from './routers/index';

// create router routes
app:router.route('/novels', NovelRouter);
app:router.route('/', IndexRouter);

// run app router
app:router.run();
