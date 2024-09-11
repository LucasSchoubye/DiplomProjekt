import React, { useState } from 'react';

const StudentStats = ({ answerMap }) => {
    // Flatten the answerMap into a single array of answers
    const answers = Object.values(answerMap).flat();

    // Group the answers by subject and subtopic
    const groupedAnswers = answers.reduce((acc, answer) => {
        const { subject, subtopic } = answer;
        if (!acc[subject]) {
            acc[subject] = {};
        }
        if (!acc[subject][subtopic]) {
            acc[subject][subtopic] = [];
        }
        acc[subject][subtopic].push(answer);
        return acc;
    }, {});

    const [selectedSubject, setSelectedSubject] = useState(null);
    const [selectedSubtopic, setSelectedSubtopic] = useState(null);

    // Handle subject click
    const handleSubjectClick = (subject) => {
        setSelectedSubject(selectedSubject === subject ? null : subject);
    };

    // Handle subtopic click
    const handleSubtopicClick = (subtopic) => {
        setSelectedSubtopic(selectedSubtopic === subtopic ? null : subtopic);
    };

    // Handle back to subject list
    const handleBackToSubject = () => {
        setSelectedSubject(null);
        setSelectedSubtopic(null);
    };

    return (
        <div style={{ marginLeft: '20px', padding: '10px', border: '1px solid #ddd', borderRadius: '5px', flexGrow: 1 }}>
            <h3>Answers by Subject</h3>

            {/* If a subject is selected, show a back button */}
            {selectedSubject && (
                <button onClick={handleBackToSubject} style={{ marginBottom: '10px' }}>
                    Back to Subjects
                </button>
            )}

            {/* Render subjects */}
            {!selectedSubject ? (
                <div>
                    {Object.keys(groupedAnswers).map((subject, index) => (
                        <div key={index}>
                            {/* Subject clickable box */}
                            <div
                                onClick={() => handleSubjectClick(subject)}
                                style={{
                                    cursor: 'pointer',
                                    padding: '10px',
                                    marginBottom: '5px',
                                    backgroundColor: selectedSubject === subject ? '#f0f0f0' : '#e0e0e0',
                                    borderRadius: '5px',
                                    fontWeight: 'bold',
                                }}
                            >
                                {subject}
                            </div>
                        </div>
                    ))}
                </div>
            ) : (
                // If a subject is selected, show subtopics
                <div style={{ marginLeft: '20px' }}>
                    <h4>{selectedSubject}</h4>

                    {/* Render subtopic buttons */}
                    {Object.keys(groupedAnswers[selectedSubject]).map((subtopic, subIndex) => (
                        <div key={subIndex}>
                            <button
                                onClick={() => handleSubtopicClick(subtopic)}
                                style={{
                                    cursor: 'pointer',
                                    padding: '5px',
                                    marginBottom: '5px',
                                    backgroundColor: selectedSubtopic === subtopic ? '#d3d3d3' : '#f0f0f0',
                                    borderRadius: '3px',
                                }}
                            >
                                {subtopic}
                            </button>

                            {/* If the subtopic is selected, show its answers */}
                            {selectedSubtopic === subtopic && (
                                <ul>
                                    {groupedAnswers[selectedSubject][subtopic].map((answer, answerIndex) => (
                                        <li
                                            key={answerIndex}
                                            style={{
                                                color: answer.correct === 1 ? 'green' : 'red',
                                                marginBottom: '10px',
                                            }}
                                        >
                                            <p><strong>Prompt:</strong> {answer.prompt}</p>
                                            <p><strong>Answer:</strong> {answer.answer}</p>
                                            <p><strong>Option Chosen:</strong> {answer.optionChosen}</p>
                                            <p><strong>Time:</strong> {answer.answerTime}</p>
                                        </li>
                                    ))}
                                </ul>
                            )}
                        </div>
                    ))}
                </div>
            )}
        </div>
    );
};

export default StudentStats;
