import { Router } from "farmy";
import * as IndexController from "../controllers/indexController.fy";

const router = new Router();

router.path('/', IndexController.home);
router.path('/signup', IndexController.signup);
router.path('/login', IndexController.login);
router.path('/logout', IndexController.logout);
router.path('/~', IndexController.lost);

export default router;
