import { Router } from "farmy";
import * as UserController from "../controllers/userController.fy";

const router = new Router();

router.path('/', UserController.users);
router.path('/:userID', UserController.userByID);

export default router;
