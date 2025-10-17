CREATE TABLE student_feedback (
    StudentID INT PRIMARY KEY,
    SubjectKnowledge INT,
    ClarityOfExplanation INT,
    UseOfPresentations INT,
    AssignmentDifficulty INT,
    DoubtSolving INT,
    CourseStructure INT,
    SupportForExtraEffort INT,
    CourseRecommendation INT
);

SELECT * 
FROM student_feedback;


-- 2.Overall Averages
SELECT 
    ROUND(AVG(SubjectKnowledge),2)       AS avg_subject_knowledge,
    ROUND(AVG(ClarityOfExplanation),2)   AS avg_explanation,
    ROUND(AVG(UseOfPresentations),2)     AS avg_presentations,
    ROUND(AVG(AssignmentDifficulty),2)   AS avg_difficulty,
    ROUND(AVG(DoubtSolving),2)           AS avg_doubt_solving,
    ROUND(AVG(CourseStructure),2)        AS avg_structure,
    ROUND(AVG(SupportForExtraEffort),2)  AS avg_support,
    ROUND(AVG(CourseRecommendation),2)   AS avg_recommendation
FROM student_feedback;


-- 3.Top 3 Best-Rated Aspects
SELECT aspect, avg_rating
FROM (
    SELECT 'Subject Knowledge'        AS aspect, AVG(SubjectKnowledge)      AS avg_rating FROM student_feedback
    UNION ALL
    SELECT 'Clarity of Explanation',         AVG(ClarityOfExplanation)      FROM student_feedback
    UNION ALL
    SELECT 'Use of Presentations',           AVG(UseOfPresentations)        FROM student_feedback
    UNION ALL
    SELECT 'Assignment Difficulty',          AVG(AssignmentDifficulty)      FROM student_feedback
    UNION ALL
    SELECT 'Doubt Solving',                  AVG(DoubtSolving)              FROM student_feedback
    UNION ALL
    SELECT 'Course Structure',               AVG(CourseStructure)           FROM student_feedback
    UNION ALL
    SELECT 'Support for Extra Effort',       AVG(SupportForExtraEffort)     FROM student_feedback
) sub
ORDER BY avg_rating DESC
LIMIT 3;


-- 4.Correlation with CourseRecommendation
SELECT 
    corr(SubjectKnowledge, CourseRecommendation)       AS subject_corr,
    corr(ClarityOfExplanation, CourseRecommendation)   AS explanation_corr,
    corr(UseOfPresentations, CourseRecommendation)     AS presentations_corr,
    corr(AssignmentDifficulty, CourseRecommendation)   AS difficulty_corr,
    corr(DoubtSolving, CourseRecommendation)           AS doubt_corr,
    corr(CourseStructure, CourseRecommendation)        AS structure_corr,
    corr(SupportForExtraEffort, CourseRecommendation)  AS support_corr
FROM student_feedback;


-- 5.Low Recommenders (Rating ≤ 3)
SELECT StudentID,
       CourseRecommendation,
       SubjectKnowledge,
       ClarityOfExplanation,
       DoubtSolving
FROM student_feedback
WHERE CourseRecommendation <= 3;


-- 6.Assignment Difficulty Distribution
SELECT AssignmentDifficulty,
       COUNT(*) AS num_students
FROM student_feedback
GROUP BY AssignmentDifficulty
ORDER BY AssignmentDifficulty;


-- 7.High vs. Low Recommenders Comparison
SELECT
    CASE 
        WHEN CourseRecommendation >= 7 THEN 'High Recommenders'
        ELSE 'Low/Neutral Recommenders'
    END AS recommender_group,
    AVG(SubjectKnowledge)      AS avg_subject,
    AVG(ClarityOfExplanation)  AS avg_explanation,
    AVG(DoubtSolving)          AS avg_doubt_solving,
    AVG(CourseStructure)       AS avg_structure
FROM student_feedback
GROUP BY recommender_group;





