import React from 'react';
import { BarChart, Bar, XAxis, YAxis, Tooltip, ResponsiveContainer, Cell } from 'recharts';
import PropTypes from 'prop-types';
import { formatSubtopic } from '../../utils/textUtils';

const COLORS = ['#8884d8', '#82ca9d', '#ffc658', '#ff6666', '#66b366'];

const MedianAnswerTimeChart = ({ data, title }) => {
    return (
    <div style={{ width: '30%', textAlign: 'center' }}>
        <h3>{title}</h3>
        <ResponsiveContainer width="100%" height={575}>
            <BarChart data={data} margin={{ bottom: 50}}>
                <XAxis 
                    xAxisId="0" 
                    dataKey="subtopic" 
                    tickFormatter={formatSubtopic}
                    angle={-45} 
                    textAnchor="end" 
                    height={60} 
                    tick={{ fontSize: 12 }} 
                    interval={0}
                />
                <YAxis label={{ value: 'Median Time (s)', angle: -90, position: 'insideLeft', offset: 15 }} />
                <Tooltip 
                    formatter={(value, name) => [parseFloat(value).toFixed(2), formatSubtopic(name)]}
                    labelFormatter={label => formatSubtopic(label)}
                />
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