import React from 'react';
import { BarChart, Bar, XAxis, YAxis, Tooltip, Legend, ResponsiveContainer } from 'recharts';
import PropTypes from 'prop-types';

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

const OverallStackedBarChart = ({ data, title }) => {
    return (
        <div style={{ width: '15%', textAlign: 'center' }}>
            <h3>{title}</h3>
            <ResponsiveContainer width="100%" height={500}>
                <BarChart data={data}>
                    <XAxis type="category" dataKey="name" />
                    <YAxis type="number" label={{ value: 'Total Answers', angle: -90, position: 'insideLeft' }} />
                    <Tooltip />
                    <Bar 
                        dataKey="Correct" 
                        stackId="a" 
                        fill="#66b366"
                        label={(props) => <CustomLabel {...props} data={data} type="Correct" />}
                    />
                    <Bar 
                        dataKey="Incorrect" 
                        stackId="a" 
                        fill="#ff6666"
                        label={(props) => <CustomLabel {...props} data={data}  type="Incorrect" />}
                    />
                </BarChart>
            </ResponsiveContainer>
        </div>
    );
};

OverallStackedBarChart.propTypes = {
    data: PropTypes.arrayOf(PropTypes.shape({
        name: PropTypes.string.isRequired,
        Correct: PropTypes.number.isRequired,
        Incorrect: PropTypes.number.isRequired,
    })).isRequired,
    title: PropTypes.string,
};

OverallStackedBarChart.defaultProps = {
    title: 'Total Answers',
};

export default OverallStackedBarChart;