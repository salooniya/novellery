import { Router } from 'farmy';
import * as IndexController from '../controllers/index.fy';

// create router
const router = new Router();

// create router paths
router.path('/', IndexController.home);
router.path('/~', IndexController._404_);

export default router;
