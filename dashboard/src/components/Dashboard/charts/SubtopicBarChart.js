import React from 'react';
import { BarChart, Bar, XAxis, YAxis, Tooltip, Legend, ResponsiveContainer } from 'recharts';
import PropTypes from 'prop-types';
import { formatSubtopic } from '../../utils/textUtils';

const CustomLabel = ({ x, y, width, height, index, data, type }) => {
    const total = data[index].Incorrect + data[index].Correct;
    const percentage = type === 'Correct'
        ? ((data[index].Correct / total) * 100).toFixed(1)
        : ((data[index].Incorrect / total) * 100).toFixed(1);
    
    if (percentage === '0.0') return null;

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

const SubtopicBarChart = ({ data, title = 'Answer % per subtopic' }) => {
    return (
    <div style={{ width: '30%', textAlign: 'center' }}>
        <h3>{title}</h3>
        <ResponsiveContainer width="100%" height={575}>
            <BarChart data={data} margin={{ bottom: 50}}>
                <XAxis 
                    dataKey="name" 
                    tickFormatter={formatSubtopic} 
                    angle={-45} 
                    textAnchor="end" 
                    height={60} 
                    tick={{ fontSize: 12 }} 
                    interval={0} 
                />
                <YAxis label={{ value: 'Percentage', angle: -90, position: 'insideLeft', offset: 15 }} />
                <Tooltip 
                    formatter={(value, name) => [`${value.toFixed(2)}%`, formatSubtopic(name)]}
                    labelFormatter={label => formatSubtopic(label)}
                />
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

export default SubtopicBarChart;