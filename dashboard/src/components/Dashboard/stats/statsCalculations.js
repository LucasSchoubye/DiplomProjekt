export function calculateBasicStats(answers) {
    const totalAnswers = answers.length;
    const correctAnswers = answers.filter(({ correct }) => correct === 1).length;
    const incorrectAnswers = totalAnswers - correctAnswers;
    const totalAnswerTime = answers.reduce((sum, { answerTime }) => sum + answerTime, 0);
    const averageAnswerTime = totalAnswers > 0 ? (totalAnswerTime / totalAnswers) : 0;

    return {
        totalAnswers,
        correctAnswers,
        incorrectAnswers,
        averageAnswerTime,
        data: [{
            name: 'Answers',
            Correct: correctAnswers,
            Incorrect: incorrectAnswers,
        }]
    };
}

export function calculateSubtopicData(answers) {
    const subtopicStats = {};
    answers.forEach(({ subtopic, correct }) => {
        if (!subtopicStats[subtopic]) {
            subtopicStats[subtopic] = { name: subtopic, Correct: 0, Incorrect: 0 };
        }
        if (correct === 1) {
            subtopicStats[subtopic].Correct++;
        } else {
            subtopicStats[subtopic].Incorrect++;
        }
    });
    
    Object.keys(subtopicStats).forEach(subtopic => {
        const total = subtopicStats[subtopic].Correct + subtopicStats[subtopic].Incorrect;
        subtopicStats[subtopic].CorrectPercentage = total > 0 ? (subtopicStats[subtopic].Correct / total) * 100 : 0;
        subtopicStats[subtopic].IncorrectPercentage = total > 0 ? (subtopicStats[subtopic].Incorrect / total) * 100 : 0;
    });
    
    return Object.values(subtopicStats);
}

export function calculateAnswerTimeData(answers) {
    const questionTimeMap = {};
    answers.forEach(({ subtopic, answerTime }) => {
        if (!questionTimeMap[subtopic]) {
            questionTimeMap[subtopic] = [];
        }
        questionTimeMap[subtopic].push(answerTime);
    });

    return Object.keys(questionTimeMap).map(subtopic => {
        const times = questionTimeMap[subtopic].sort((a, b) => a - b);
        const mid = Math.floor(times.length / 2);
        const medianTime = times.length % 2 !== 0
            ? times[mid]
            : (times[mid - 1] + times[mid]) / 2;
        return {
            subtopic,
            medianTime: medianTime,
        };
    });
}

export function calculateMedianAnswerTimeData(answers) {
    const subtopicTimeMap = {};
    answers.forEach(({ subtopic, answerTime, correct }) => {
        if (!subtopicTimeMap[subtopic]) {
            subtopicTimeMap[subtopic] = { correctTimes: [], incorrectTimes: [] };
        }
        if (correct === 1) {
            subtopicTimeMap[subtopic].correctTimes.push(answerTime);
        } else {
            subtopicTimeMap[subtopic].incorrectTimes.push(answerTime);
        }
    });

    return Object.keys(subtopicTimeMap).map(subtopic => {
        const correctTimes = subtopicTimeMap[subtopic].correctTimes.sort((a, b) => a - b);
        const incorrectTimes = subtopicTimeMap[subtopic].incorrectTimes.sort((a, b) => a - b);
        const correctMid = Math.floor(correctTimes.length / 2);
        const incorrectMid = Math.floor(incorrectTimes.length / 2);
        const medianCorrectTime = correctTimes.length % 2 !== 0
            ? correctTimes[correctMid]
            : (correctTimes[correctMid - 1] + correctTimes[correctMid]) / 2;
        const medianIncorrectTime = incorrectTimes.length % 2 !== 0
            ? incorrectTimes[incorrectMid]
            : (incorrectTimes[incorrectMid - 1] + incorrectTimes[incorrectMid]) / 2;
        
        return {
            name: subtopic,
            'Correct Time': isNaN(medianCorrectTime) ? 0 : medianCorrectTime,
            'Incorrect Time': isNaN(medianIncorrectTime) ? 0 : medianIncorrectTime,
        };
    });
}