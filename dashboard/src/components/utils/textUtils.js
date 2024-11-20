export const formatSubtopic = (subtopic) => {
    return subtopic.charAt(0).toUpperCase() + subtopic.slice(1).replace(/([A-Z])/g, ' $1').toLowerCase();
};