import React, { useState, useEffect } from 'react';
import { Link  } from "react-router-dom";
import { useForm } from "react-hook-form";
import { Table, Row, Alert, Button, Modal } from 'react-bootstrap'
import axios from 'axios';

import {BASE_URL} from './../Constants'

function Home() {
    const { register, handleSubmit, reset } = useForm();
    const [surveys, setSurveys] = useState([]);
    const [show, setShow] = useState(false);
    const [survey, setSurvey] = useState({});
    const [question, setQuestion] = useState({});

    const modalClose = () => setShow(false);

    const modelShow = (survey_id) => {
        axios.get(`${BASE_URL}/surveys/${survey_id}`)
        .then(res => {
            const survey = res.data;
            setSurvey(survey);
            if(survey.question === undefined){
                alert("This survey does not have any question. Please try other survey.")
            }else{
            setQuestion(survey.question);
            setShow(true);
            }
        })
        
    };

    const onSubmit = (data, e) => {
        console.log(data)
        let answer_text = '';
        if(question.option_type === 'multiple_choice' && data.answer_text.length !== 0){
            answer_text = data.answer_text.join(", ")
        }else{
            answer_text = data.answer_text
        }
        console.log(answer_text)

        if(answer_text === ''){
            alert("No answer provided");
            return 0;
        }

        axios.post(`${BASE_URL}/surveys/${survey.id}/answers`, {
            question_id: question.id,
            answer_text: answer_text
            })
        .then(res => {
            const question = res.data;
            e.target.reset()
            if(question.id === undefined){
                alert("This survey has been completed. Thanks for the answer.");
                setShow(false);
            }else{
                setQuestion(question);
            }
        })
        
 
    }

    // Similar to componentDidMount and componentDidUpdate:
    useEffect(() => {
        // Update the surveys using the backend API
        axios.get(`${BASE_URL}/surveys`)
        .then(res => {
            const surveys = res.data;
            setSurveys(surveys);
        })
    }, []);

  return (
    <Row>
        <Alert variant="success">
            <Alert.Heading>Surveys</Alert.Heading>
            <p className="mb-0">
                This is the list of all surveys. Form here you can check the survey answers. 
                Also you can participate and submit the answer of a survey.
            </p>
        </Alert>
      <Table striped bordered hover>
        <thead>
            <tr>
            <th>#</th>
            <th>Survey Title</th>
            <th>Created At</th>
            <th>Actions</th>
            </tr>
        </thead>
        <tbody>

        {surveys.map((survey, index) => {

        return (<tr key={index}>
                    <td>{index+1}</td>
                    <td>{survey.survey_title}</td>
                    <td>{survey.created_at}</td>
                    <td>
                        <Link to={`/survey/${survey.id}/answers`}>Show Answers</Link>{' '}|
                        <Button variant="link"  onClick={() => modelShow(survey.id)}>Submit Answer</Button>
                    </td>
                </tr>)
        })}
            
         
        </tbody>
        </Table>

        <Modal show={show} onHide={modalClose}>
        <Modal.Header closeButton>
          <Modal.Title>Question of: {survey.survey_title}</Modal.Title>
        </Modal.Header>
        <Modal.Body>
            <p className="text-success">Choose or input the question answer and click on the <b>Save & Next</b> button.</p>

                <form onSubmit={handleSubmit(onSubmit)}>

                {question.option_type === 'input_text' ? (
                            <div>
                                <p><b>Question Title:</b> {question.question_title}</p>
                                <b>Your Answer:</b> <input name="answer_text"  ref={register({ required: true })} />
                            </div>
                        ) : null}
                     
                {question.option_type === 'single_choice' ? (
                    <div>
                        <p><b>Question Title:</b> {question.question_title}</p>
                        <b>Select One:</b> <br/>
                        {question.choices.map((choice, index) => {
                            return  <div  key={index} > 
                            <input type="radio" value={choice.choice_title} name="answer_text" ref={register({ required: true })} /> {choice.choice_title} <br/>
                            </div>
                        })}
                    </div>
                ) : null}
                     
                {question.option_type === 'multiple_choice' ? (
                    <div>
                        <p><b>Question Title:</b> {question.question_title}</p>
                        <b>Choose your answers:</b> <br/>
                        {question.choices.map((choice, index) => {
                            return  <div  key={index} > 
                            <input type="checkbox" value={choice.choice_title} name="answer_text"  ref={register} /> {choice.choice_title} <br/>
                            </div>
                        })}
                    </div>
                ) : null}
                     
                    {/* errors will return when field validation fails  */}
                    {/* {errors.exampleRequired && <span>This field is required</span>} */}
                    <br/><br/>
                    <input type="submit" value="Save & Next"/>
                </form>



        </Modal.Body>
        <Modal.Footer>
          <Button variant="secondary" onClick={modalClose}>
            Cancel
          </Button>
          {/* <Button variant="primary" onClick={submitAnswer}>
            Save & Next
          </Button> */}
        </Modal.Footer>
      </Modal>
    </Row>
  );
}

export default Home;
