import { Router } from "farmy";
import * as UserController from "../controllers/userController.fy";

const router = new Router();

router.path('/', UserController.authors);
router.path('/:userID', UserController.authorByID);

export default router;

