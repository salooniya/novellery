import { State, Router, Component, View, $ } from 'farmy';

// create router
const router = new Router();

// home path
router PATH '/' () => console.log('Home');

// user path
router PATH '/users/:userID' (req) => console.log(`User - ${req.params.userID}`);

// novel path
router PATH '/novels/:novelID' (req) => console.log(`Novel - ${req.params.novelID}`);

// chapter path
router PATH '/novels/:novelID/chapters/:chapterID' (req) => console.log(`Chapter - ${req.params.chapterID}`);

// author path
router PATH '/authors/:authorID' (req) => console.log(`Novel - ${req.params.authorID}`);

// 404 path
router PATH '/~' (req) => console.log(`404 - ${location.pathname}`);

export default router;
