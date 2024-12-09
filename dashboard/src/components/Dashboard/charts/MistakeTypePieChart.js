import React from 'react';
import { PieChart, Pie, Cell, Tooltip, ResponsiveContainer, Label } from 'recharts';
import PropTypes from 'prop-types';
import { formatSubtopic } from '../../utils/textUtils';

const COLORS = ['#0088FE', '#00C49F', '#FFBB28', '#FF8042', '#8884d8'];

const RADIAN = Math.PI / 180;
const renderCustomizedLabel = ({
    cx, cy, midAngle, innerRadius, outerRadius, index, name
}) => {
    const radius = outerRadius * 1.2;
    const x = cx + radius * Math.cos(-midAngle * RADIAN);
    const y = cy + radius * Math.sin(-midAngle * RADIAN);

    const positionAdjust = x > cx ? 15 : -15;

    return (
        <g>
            <text
                x={x + positionAdjust}
                y={y}
                textAnchor={x > cx ? 'start' : 'end'}
                dominantBaseline="central"
                style={{ fontSize: '12px' }}
            >
                {formatSubtopic(name)}
            </text>
            <line
                x1={cx + (outerRadius + 5) * Math.cos(-midAngle * RADIAN)}
                y1={cy + (outerRadius + 5) * Math.sin(-midAngle * RADIAN)}
                x2={x - (positionAdjust/Math.abs(positionAdjust) * 5)}
                y2={y}
                stroke="#666"
                strokeWidth={1}
            />
        </g>
    );
};

const renderCenterLabel = ({ value, name }) => {
    return `${(value * 100).toFixed(0)}%`;
};

const MistakeTypePieChart = ({ data }) => {
    const total = data.reduce((sum, entry) => sum + entry.value, 0);
    const normalizedData = data.map(entry => ({
        ...entry,
        displayName: formatSubtopic(entry.name),
        value: entry.value / total
    }));

    return (
        <div style={{ width: '30%', textAlign: 'center' }}>
            <h3>Mistake Type Distribution</h3>
            <ResponsiveContainer width="100%" height={575}>
                <PieChart>
                    <Pie
                        data={normalizedData}
                        labelLine={false}
                        label={renderCustomizedLabel}
                        dataKey="value"
                        nameKey="name"
                        cx="50%"
                        cy="50%"
                        outerRadius={100}
                    >
                        {normalizedData.map((entry, index) => (
                            <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]}>
                                <Label
                                    position="center"
                                    content={renderCenterLabel}
                                />
                            </Cell>
                        ))}
                    </Pie>
                    <Tooltip 
                        formatter={(value, name) => [
                            `${(value * 100).toFixed(0)}%`,
                            formatSubtopic(name)
                        ]}
                    />
                </PieChart>
            </ResponsiveContainer>
        </div>
    );
};

MistakeTypePieChart.propTypes = {
    data: PropTypes.arrayOf(PropTypes.shape({
        name: PropTypes.string.isRequired,
        value: PropTypes.number.isRequired,
    })).isRequired,
};

export default MistakeTypePieChart;