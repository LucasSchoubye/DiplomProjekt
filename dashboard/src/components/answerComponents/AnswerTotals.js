import React from "react";
import { List, ListItem, ListItemText, Divider, Typography } from "@mui/material";

const AnswerTotals = ({ correctAnswers, incorrectAnswers }) => {
    const totalAnswers = correctAnswers.length + incorrectAnswers.length;
    const percentageCorrect = (correctAnswers.length / totalAnswers * 100).toFixed(2);

    return (
        <div>
            <Typography variant="h5" gutterBottom>
                Totals
            </Typography>
            <List style={{ width: '100%', borderRadius: 4, border: "1px solid", borderColor: "divider", padding: 1 }}>
                <ListItem style={{ padding: '4px 16px' }}>
                    <ListItemText
                        primary="Total correct answers"
                        secondary={correctAnswers.length}
                        primaryTypographyProps={{ color: "green" }}
                    />
                </ListItem>
                <Divider />
                <ListItem style={{ padding: '4px 16px' }}>
                    <ListItemText
                        primary="Total incorrect answers"
                        secondary={incorrectAnswers.length}
                        primaryTypographyProps={{ color: "red" }}
                    />
                </ListItem>
                <Divider />
                <ListItem style={{ padding: '4px 16px' }}>
                    <ListItemText
                        primary="Total percentage correct"
                        secondary={totalAnswers > 0 ? `${percentageCorrect}%` : "0%"}
                        primaryTypographyProps={{ color: "black" }}
                    />
                </ListItem>
            </List>
        </div>
    );

        // <div>
           
        //     <h1>Totals</h1>
        //     <h3 style={{ color: "green" }}>
        //         Total correct answers: {correctAnswers.length}
        //     </h3>
        //     <h3 style={{ color: "red" }}>
        //         Total incorrect answers: {incorrectAnswers.length}
        //     </h3>
        //     <h3 style={{ color: "black" }}>
        //         Total percentage correct: {totalAnswers > 0 ? `${percentageCorrect}%` : "0%"}
        //     </h3>
        // </div>
    // );
};

export default AnswerTotals;