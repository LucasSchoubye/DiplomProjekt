import React from 'react';
import { BarChart, Bar, XAxis, YAxis, Tooltip, Legend, ResponsiveContainer } from 'recharts';
import PropTypes from 'prop-types';
import { formatSubtopic } from '../../utils/textUtils';

const CustomLabel = ({ x, y, width, height, index, data, type }) => {
    const total = data[index].Incorrect + data[index].Correct;
    const percentage = type === 'Correct'
        ? ((data[index].Correct / total) * 100).toFixed(1)
        : ((data[index].Incorrect / total) * 100).toFixed(1);
    
    return (
        <text
            x={x + width / 2}
            y={y + height / 2}
            fill="#ffffff"
            textAnchor="middle"
            dominantBaseline="middle"
            fontSize={16}
        >
            {`${percentage}%`}
        </text>
    );
};

const SubtopicBarChart = ({ data, title }) => {
    return (
    <div style={{ width: '30%', textAlign: 'center' }}>
        <h3>{title}</h3>
        <ResponsiveContainer width="100%" height={500}>
            <BarChart data={data}>
                <XAxis dataKey="name" tickFormatter={formatSubtopic} />
                <YAxis label={{ value: 'Percentage', angle: -90, position: 'insideLeft' }} />
                <Tooltip formatter={(value) => `${value.toFixed(2)}%`} />
                {/* <Legend /> */}
                <Bar 
                    dataKey="CorrectPercentage" 
                    stackId="a" 
                    fill="#66b366" 
                    label={(props) => <CustomLabel {...props} data={data} type="Correct" />}
                />
                <Bar 
                    dataKey="IncorrectPercentage" 
                    stackId="a" 
                    fill="#ff6666" 
                    label={(props) => <CustomLabel {...props} data={data} type="Incorrect" />}
                />
            </BarChart>
        </ResponsiveContainer>
    </div>
    );
};

SubtopicBarChart.propTypes = {
    data: PropTypes.arrayOf(PropTypes.shape({
        name: PropTypes.string.isRequired,
        Correct: PropTypes.number.isRequired,
        Incorrect: PropTypes.number.isRequired,
        CorrectPercentage: PropTypes.number.isRequired,
        IncorrectPercentage: PropTypes.number.isRequired,
    })).isRequired,
};

SubtopicBarChart.defaultProps = {
    title: 'Answer % per subtopic',
};

export default SubtopicBarChart;