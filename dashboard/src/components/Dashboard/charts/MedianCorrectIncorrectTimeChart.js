
import React from 'react';
import { BarChart, Bar, XAxis, YAxis, Tooltip, ResponsiveContainer, Cell, Legend } from 'recharts';
import PropTypes from 'prop-types';
import { formatSubtopic } from '../../utils/textUtils';

const COLORS = ['#66b366', '#ff6666'];

const MedianCorrectIncorrectTimeChart = ({ data, title }) => {
    return (
        <div style={{ width: '30%', textAlign: 'center' }}>
            <h3>{title}</h3>
            <ResponsiveContainer width="100%" height={575}>
                <BarChart data={data} margin={{ bottom: 50 }}>
                    <XAxis 
                        dataKey="name" 
                        tickFormatter={formatSubtopic}
                        angle={-45} 
                        textAnchor="end" 
                        height={60} 
                        tick={{ fontSize: 12 }} 
                        interval={0}
                    />
                    <YAxis label={{ value: 'Median Time (s)', angle: -90, position: 'insideLeft', offset: 20 }} />
                    <Tooltip />
                    {/* <Legend /> */}
                    <Bar dataKey="Correct Time" fill={COLORS[0]}>
                        {data.map((entry, index) => (
                            <Cell key={`cell-correct-${index}`} fill={COLORS[0]} />
                        ))}
                    </Bar>
                    <Bar dataKey="Incorrect Time" fill={COLORS[1]}>
                        {data.map((entry, index) => (
                            <Cell key={`cell-incorrect-${index}`} fill={COLORS[1]} />
                        ))}
                    </Bar>
                </BarChart>
            </ResponsiveContainer>
        </div>
    );
};

MedianCorrectIncorrectTimeChart.propTypes = {
    data: PropTypes.arrayOf(PropTypes.shape({
        name: PropTypes.string.isRequired,
        'Correct Time': PropTypes.string.isRequired,
        'Incorrect Time': PropTypes.string.isRequired,
    })).isRequired,
};

MedianCorrectIncorrectTimeChart.defaultProps = {
    title: 'Median Correct and Incorrect Answer Time',
};

export default MedianCorrectIncorrectTimeChart;