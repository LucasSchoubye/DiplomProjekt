import React from 'react';
import { Checkbox, FormControlLabel, Input, Button } from "@mui/material";

const AnswerForm = ({ onSubmit, newAnswer, setAnswer, isAnswerCorrect, setIsAnswerCorrect }) => {
    return (
        <div>
            <h1>Create new entry</h1>
            <Input placeholder="Type new answer"
            value={newAnswer} 
            onChange={(inputEvent) => setAnswer(inputEvent.target.value)} />
            <FormControlLabel control={<Checkbox 
            checked={isAnswerCorrect}
            onChange={(inputEvent) => setIsAnswerCorrect(inputEvent.target.checked)} />} label="Correct" />
            <Button onClick={onSubmit} variant="contained">Submit</Button>
        </div>
    );
};

export default AnswerForm;