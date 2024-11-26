
import React from 'react';
import { BarChart, Bar, XAxis, YAxis, Tooltip, ResponsiveContainer, Cell } from 'recharts';
import PropTypes from 'prop-types';
import { formatSubtopic } from '../../utils/textUtils';

const COLORS = ['#8884d8', '#82ca9d', '#ffc658', '#ff6666', '#66b366'];

const MedianAnswerTimeChart = ({ data, title }) => {
    return (
    <div style={{ width: '30%', textAlign: 'center' }}>
        <h3>{title}</h3>
        <ResponsiveContainer width="100%" height={500}>
            <BarChart data={data}>
                <XAxis 
                    xAxisId="0" 
                    dataKey="subtopic" 
                    tickFormatter={formatSubtopic} 
                    label={{ value: 'Question Type', position: 'insideBottom', offset: -2 }} 
                />
                <YAxis label={{ value: 'Median Time (s)', angle: -90, position: 'insideLeft' }} />
                <Tooltip />
                <Bar dataKey="medianTime">
                    {data.map((entry, index) => (
                        <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                    ))}
                </Bar>
            </BarChart>
        </ResponsiveContainer>
    </div>
    );
};

MedianAnswerTimeChart.propTypes = {
    data: PropTypes.arrayOf(PropTypes.shape({
        subtopic: PropTypes.string.isRequired,
        medianTime: PropTypes.string.isRequired,
    })).isRequired,
};

MedianAnswerTimeChart.defaultProps = {
    title: 'Median Answer Time',
};

export default MedianAnswerTimeChart;