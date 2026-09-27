let exampleWord = VocabWord(
    thai: "ฉัน",
    pronunciation: "chan",
    english: "I / Me",
    type: "Pronoun"
)

let lessonOneWords: [VocabWord] = [
    VocabWord(
        thai: "ก",
        pronunciation: "gaw",
        english: "g / k sound",
        type: "Consonant"
    ),
    VocabWord(
        thai: "ม",
        pronunciation: "maw",
        english: "m sound",
        type: "Consonant"
    ),
    VocabWord(
        thai: "า",
        pronunciation: "aa",
        english: "long a vowel",
        type: "Vowel"
    ),
    VocabWord(
        thai: "กา",
        pronunciation: "kaa",
        english: "crow",
        type: "Word"
    ),
    VocabWord(
        thai: "กา",
        pronunciation: "kaa",
        english: "crow",
        type: "Word"
    ),
    VocabWord(
        thai: "มา",
        pronunciation: "maa",
        english: "come",
        type: "Word"
    ),
    VocabWord(
        thai: "มา",
        pronunciation: "maa",
        english: "come",
        type: "Word"
    )
]

let lessonOneSteps: [LessonStep] = [
    LessonStep(
        type: .explanation,
        thai: "ก",
        explanation: "Tap the speaker button to hear the character, and the Next button to move on!",
        requiresSpeaking: false
    ),
    LessonStep(
        type: .character,
        thai: "ม",
        explanation: "none",
        requiresSpeaking: false
    ),
    LessonStep(
        type: .explanation,
        thai: "า",
        explanation: "This is a vowel (called sara / สระ), which makes an “aa” sound. We’ll combine it with the consonants you just learned.",
        requiresSpeaking: false
    ),
    LessonStep(
        type: .word,
        thai: "มา",
        explanation: "none",
        requiresSpeaking: false
    ),
    LessonStep(
        type: .word,
        thai: "กา",
        explanation: "Here the g/k sound from ก combines with the aa sound from า to make the word กา",
        requiresSpeaking: false
    ),
    LessonStep(
        type: .speaking,
        thai: "มา",
        explanation: "Now what do you think this sounds like?",
        requiresSpeaking: true
    ),
    LessonStep(
        type: .speaking,
        thai: "มา",
        explanation: "Good job!",
        requiresSpeaking: false
    )
]
