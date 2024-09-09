import React from 'react';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Paper from '@mui/material/Paper';
import Button from '@mui/material/Button';
import { styled } from '@mui/material/styles';

// Styling for correct and incorrect answers
const CorrectAnswerCell = styled(TableCell)({
    color: 'green',
    fontWeight: 'bold',
});

const IncorrectAnswerCell = styled(TableCell)({
    color: 'red',
    fontWeight: 'bold',
});

const AnswersTable = ({ correctAnswers, incorrectAnswers, onDelete }) => {
    return (
        <TableContainer component={Paper}>
            <Table sx={{ minWidth: 650 }} aria-label="answers table">
                <TableHead>
                    <TableRow>
                        <TableCell>Answer</TableCell>
                        <TableCell align="left">Options</TableCell>
                        <TableCell align="left">Question Template</TableCell>
                        <TableCell align="left">Correct/Incorrect</TableCell>
                        <TableCell align="left">Actions</TableCell>
                    </TableRow>
                </TableHead>
                <TableBody>
                    {/* Render correct answers */}
                    {correctAnswers.map((answer) => (
                        <TableRow key={answer.id}>
                            <CorrectAnswerCell>{answer.answerName}</CorrectAnswerCell>
                            <TableCell>{Array.isArray(answer.testOptions) ? answer.testOptions.join(', ') : answer.testOptions}</TableCell>
                            <TableCell>{answer.testQuestionTemplate?._key?.path?.segments?.slice(-1)[0]}</TableCell>
                            <CorrectAnswerCell>Correct</CorrectAnswerCell>
                            <TableCell>
                                <Button variant="outlined" color="error" onClick={() => onDelete(answer.id)}>
                                    Delete
                                </Button>
                            </TableCell>
                        </TableRow>
                    ))}
                    {/* Render incorrect answers */}
                    {incorrectAnswers.map((answer) => (
                        <TableRow key={answer.id}>
                            <IncorrectAnswerCell>{answer.answerName}</IncorrectAnswerCell>
                            <TableCell>{Array.isArray(answer.testOptions) ? answer.testOptions.join(', ') : answer.testOptions}</TableCell>
                            <TableCell>{answer.testQuestionTemplate?._key?.path?.segments?.slice(-1)[0]}</TableCell>
                            <IncorrectAnswerCell>Incorrect</IncorrectAnswerCell>
                            <TableCell>
                                <Button variant="outlined" color="error" onClick={() => onDelete(answer.id)}>
                                    Delete
                                </Button>
                            </TableCell>
                        </TableRow>
                    ))}
                </TableBody>
            </Table>
        </TableContainer>
    );
};

export default AnswersTable;
