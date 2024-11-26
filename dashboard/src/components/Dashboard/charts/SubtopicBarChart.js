
import React from 'react';
import { BarChart, Bar, XAxis, YAxis, Tooltip, Legend, ResponsiveContainer } from 'recharts';
import PropTypes from 'prop-types';
import { formatSubtopic } from '../../utils/textUtils';

const SubtopicBarChart = ({ data, title }) => {
    console.log(data);
    return (
    <div style={{ width: '30%', textAlign: 'center' }}>
        <h3>{title}</h3>
        <ResponsiveContainer width="100%" height={500}>
            <BarChart data={data}>
                <XAxis dataKey="name" tickFormatter={formatSubtopic} />
                <YAxis label={{ value: 'Total Answers', angle: -90, position: 'insideLeft' }}  />
                <Tooltip />
                {/* <Legend /> */}
                <Bar dataKey="Correct" stackId="a" fill="#66b366" />
                <Bar dataKey="Incorrect" stackId="a" fill="#ff6666" />
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
    })).isRequired,
};

SubtopicBarChart.defaultProps = {
    title: 'Total Answers Per Subtopic',
};


export default SubtopicBarChart;