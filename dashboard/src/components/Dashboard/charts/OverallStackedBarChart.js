
import React from 'react';
import { BarChart, Bar, XAxis, YAxis, Tooltip, Legend, ResponsiveContainer } from 'recharts';
import PropTypes from 'prop-types';

const OverallStackedBarChart = ({ data }) => {
    return (
        <ResponsiveContainer width="15%" height={500}>
            <BarChart data={data}>
                <XAxis type="category" dataKey="name" />
                <YAxis type="number" label={{ value: 'Total Answers', angle: -90, position: 'insideLeft' }} />
                <Tooltip />
                {/* <Legend /> */}
                <Bar dataKey="Correct" stackId="a" fill="#66b366"/>
                <Bar dataKey="Incorrect" stackId="a" fill="#ff6666"/>
            </BarChart>
        </ResponsiveContainer>
    );
};

OverallStackedBarChart.propTypes = {
    data: PropTypes.arrayOf(PropTypes.shape({
        name: PropTypes.string.isRequired,
        Correct: PropTypes.number.isRequired,
        Incorrect: PropTypes.number.isRequired,
    })).isRequired,
};

export default OverallStackedBarChart;