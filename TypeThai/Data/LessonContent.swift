let exampleWord = VocabWord(
    thai: "ฉัน",
    pronunciation: "chan",
    english: "I / Me",
    type: "Pronoun"
)

let lessonOneSteps: [LessonStep] = [
    LessonStep(
        type: .explanation,
        thai: "ก",
        explanation: "Tap the speaker button to hear the character, and the Next button to move on!",
        requiresSpeaking: false,
        word: VocabWord(
            thai: "ก",
            pronunciation: "gaw",
            english: "g / k sound",
            type: "Consonant"
        )
    ),
    LessonStep(
        type: .character,
        thai: "ม",
        explanation: "none",
        requiresSpeaking: false,
        word: VocabWord(
            thai: "ม",
            pronunciation: "maw",
            english: "m sound",
            type: "Consonant"
        ),
    ),
    LessonStep(
        type: .explanation,
        thai: "า",
        explanation: "This is a vowel (called sara / สระ), which makes an “aa” sound. We’ll combine it with the consonants you just learned.",
        requiresSpeaking: false,
        word: VocabWord(
            thai: "า",
            pronunciation: "aa",
            english: "long a vowel",
            type: "Vowel"
        )
    ),
    LessonStep(
        type: .word,
        thai: "มา",
        explanation: "none",
        requiresSpeaking: false,
        word: VocabWord(
            thai: "กา",
            pronunciation: "kaa",
            english: "crow",
            type: "Word"
        )
    ),
    LessonStep(
        type: .word,
        thai: "กา",
        explanation: "Here the g/k sound from ก combines with the aa sound from า to make the word กา",
        requiresSpeaking: false,
        word: VocabWord(
            thai: "กา",
            pronunciation: "kaa",
            english: "crow",
            type: "Word"
        )
    ),
    LessonStep(
        type: .speaking,
        thai: "มา",
        explanation: "Now what do you think this sounds like?",
        requiresSpeaking: true,
        word: VocabWord(
            thai: "มา",
            pronunciation: "maa",
            english: "come",
            type: "Word"
        )
    ),
    LessonStep(
        type: .speaking,
        thai: "มา",
        explanation: "Good job!",
        requiresSpeaking: false,
        word: VocabWord(
            thai: "มา",
            pronunciation: "maa",
            english: "come",
            type: "Word"
        )
    )
]

let lessonTwoSteps: [LessonStep] = [
    LessonStep(
        type: .explanation,
        thai: "ด",
        explanation: "Here’s a new consonant! Tap the speaker button and listen to its sound.",
        requiresSpeaking: false,
        word: VocabWord(
            thai: "ด",
            pronunciation: "daw",
            english: "d sound",
            type: "Consonant"
        )
    ),

    LessonStep(
        type: .character,
        thai: "ี",
        explanation: "none",
        requiresSpeaking: false,
        word: VocabWord(
            thai: "ี",
            pronunciation: "ee",
            english: "long ee vowel",
            type: "Vowel"
        )
    ),

    LessonStep(
        type: .explanation,
        thai: "ี",
        explanation: "This vowel makes a long “ee” sound, like the vowel in “see.” Unlike า, it is written above the consonant.",
        requiresSpeaking: false,
        word: VocabWord(
            thai: "ี",
            pronunciation: "ee",
            english: "long ee vowel",
            type: "Vowel"
        )
    ),

    LessonStep(
        type: .word,
        thai: "ดี",
        explanation: "Here ด combines with the long ee sound from ี to make ดี.",
        requiresSpeaking: false,
        word: VocabWord(
            thai: "ดี",
            pronunciation: "dee",
            english: "good",
            type: "Word"
        )
    ),

    LessonStep(
        type: .word,
        thai: "มี",
        explanation: "Remember ม from the last lesson? Combine it with ี and you get มี.",
        requiresSpeaking: false,
        word: VocabWord(
            thai: "มี",
            pronunciation: "mee",
            english: "have / there is",
            type: "Word"
        )
    ),

    LessonStep(
        type: .speaking,
        thai: "มี",
        explanation: "You’ve seen both of these symbols before. What do you think this sounds like?",
        requiresSpeaking: true,
        word: VocabWord(
            thai: "มี",
            pronunciation: "mee",
            english: "have / there is",
            type: "Word"
        )
    ),

    LessonStep(
        type: .speaking,
        thai: "ดี",
        explanation: "Now try this one!",
        requiresSpeaking: true,
        word: VocabWord(
            thai: "ดี",
            pronunciation: "dee",
            english: "good",
            type: "Word"
        )
    ),

    LessonStep(
        type: .speaking,
        thai: "ดี",
        explanation: "Good job! You can now read words using า and ี.",
        requiresSpeaking: false,
        word: VocabWord(
            thai: "ดี",
            pronunciation: "dee",
            english: "good",
            type: "Word"
        )
    )
]
