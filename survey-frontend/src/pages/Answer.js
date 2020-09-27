import React, { useState, useEffect } from 'react';
import { Link  } from "react-router-dom";
import { Row, Alert, Button} from 'react-bootstrap'
import axios from 'axios';
import { useParams } from "react-router-dom";

import {BASE_URL} from './../Constants'

function Answer() {

    const [survey, setSurvey] = useState([]);
    let { survey_id } = useParams();

    // Similar to componentDidMount and componentDidUpdate:
    useEffect(() => {

        // get the surveys using the backend API
        axios.get(`${BASE_URL}/surveys/${survey_id}/answers`)
        .then(res => {
            const survey = res.data;
            setSurvey(survey);
        })
    }, []);

  return (
    <Row>
        <div>
        <Alert variant="success">
            <Alert.Heading>Survey Title: <b>{survey.survey_title}</b></Alert.Heading>
            <p className="mb-0">
                Total Questions: {survey.questions ? survey.questions.length : null}
            </p>
            <p className="mb-0">
                List of all question and answer against this survey.
            </p>
            <p>
                <Link to="/">Go back</Link>
            </p>
        </Alert>
    
        <ul>

            {survey.questions ? (
                survey.questions.map((question, index) => {

                    return (
                        <li key={index}>
                            Question Title: {question.question_title} <br/>  
                            Total Answers: {question.answers.length} <br/>  
                            <b>Answers</b>
                            <ul>
                            {question.answers.map((answer, index) => { 
                                    return <li key={index}> {answer.answer_text} </li>
                            })} 
                            </ul>

                        </li>
                    )
                })
            ) : null }

        </ul>
        <Link to="/"><Button variant="primary">Go Back</Button></Link>
        </div>
    </Row>
  );
}

export default Answer;
