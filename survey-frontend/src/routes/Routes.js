import React from 'react';
import {
  BrowserRouter as Router,
  Switch,
  Route
} from "react-router-dom";

  // import pages
  import Home from '../pages/Home'
  import Answer from '../pages/Answer'

function Routes() {
  return (
    <Router>
        <Switch>
            <Route path="/survey/:survey_id/answers">
            <Answer />
            </Route>
            <Route path="/">
            <Home />
            </Route>
    </Switch>
    </Router>
  );
}

export default Routes;
