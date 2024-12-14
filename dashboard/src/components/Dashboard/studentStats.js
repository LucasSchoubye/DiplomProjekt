import React, { useMemo } from 'react';
import PropTypes from 'prop-types';
import { formatSubtopic } from '../utils/textUtils';
import SubtopicBarChart from './charts/SubtopicBarChart';
import OverallStackedBarChart from './charts/OverallStackedBarChart';
import MistakeTypePieChart from './charts/MistakeTypePieChart';
import MedianCorrectIncorrectTimeChart from './charts/MedianCorrectIncorrectTimeChart';
import {
    calculateBasicStats,
    calculateSubtopicData,
    calculateMistakeTypeData,
    calculateMedianAnswerTimeData
} from './stats/statsCalculations';

const StudentStats = ({ answerMap, contextType }) => {
    const answers = useMemo(() => Object.values(answerMap).flat(), [answerMap]);
    const { averageAnswerTime, data } = useMemo(() => calculateBasicStats(answers), [answers]);
    const subtopicData = useMemo(() => calculateSubtopicData(answers), [answers]);
    const mistakeTypeData = useMemo(() => calculateMistakeTypeData(answers), [answers]);
    const medianAnswerTimeData = useMemo(() => calculateMedianAnswerTimeData(answers), [answers]);

    return (
        <div className="student-stats">
            <h3>Student Statistics</h3>
            <div className="stats-details">
                <p>
                    <strong>Average Answer Time:</strong> 
                    <span className="average-answer-time"> {averageAnswerTime.toFixed(2)} seconds</span>
                </p>
            </div>

            <div className="charts-container">
                <OverallStackedBarChart data={data} />
                <SubtopicBarChart data={subtopicData} />
                <MistakeTypePieChart data={mistakeTypeData} />
                <MedianCorrectIncorrectTimeChart data={medianAnswerTimeData} />
            </div>
        </div>
    );
};

StudentStats.propTypes = {
    answerMap: PropTypes.object.isRequired,
    contextType: PropTypes.string.isRequired,
};

export default StudentStats;
