const defaultTheme = require("tailwindcss/defaultTheme");
const plugin = require("tailwindcss/plugin");
const Color = require("color");

module.exports = {
  future: {
    // removeDeprecatedGapUtilities: true,
    // purgeLayersByDefault: true,
  },
  purge: [],
  theme: {
    extend: {
      colors: {
        'primary': {
            '50': '#f4faf8',
            '100': '#e9f6f2',
            '200': '#c8e8de',
            '300': '#a6d9c9',
            '400': '#64bda1',
            '500': '#21a179',
            '600': '#1e916d',
            '700': '#19795b',
            '800': '#146149',
            '900': '#104f3b'
        },
      },
      width:{
        '72': '18rem',
        '80': '20rem',
        '88': '22rem',
        '96': '24rem',
      },
      height: {

        '72': '18rem',
        '80': '20rem',
        '88': '22rem',
        '96': '24rem',


        '1/2': '50%',

        '1/3': '33.333333%',
        '2/3': '66.666667%',

        '1/4': '25%',
        '2/4': '50%',
        '3/4': '75%',

        '1/5': '20%',
        '2/5': '40%',
        '3/5': '60%',
        '4/5': '80%',

        '1/6': '16.666667%',
        '2/6': '33.333333%',
        '3/6': '50%',
        '4/6': '66.666667%',
        '5/6': '83.333333%',

        '1/12': '8.333333%',
        '2/12': '16.666667%',
        '3/12': '25%',
        '4/12': '33.333333%',
        '5/12': '41.666667%',
        '6/12': '50%',
        '7/12': '58.333333%',
        '8/12': '66.666667%',
        '9/12': '75%',
        '10/12': '83.333333%',
        '11/12': '91.666667%',
      },
      fontFamily: {
        sans: ['Barlow', ...defaultTheme.fontFamily.sans],
        body: ['Barlow', 'sans-serif'],
      },
    },
    themeVariants: [],
        customForms: theme => ({
            default: {
                "input, textarea": {
                    "&::placeholder": {
                        color: theme("colors.gray.400")
                    }
                }
            }
        })
  },
  variants: {
        display: ["responsive"],
        textColor: ["focus-within", "hover", "focus", "active"],
        placeholderColor: ["focus"],
        borderColor: ["focus", "hover"],
        boxShadow: ["hover", "focus"]
    },
    plugins: [
        require("@tailwindcss/custom-forms"),
        plugin(({ addUtilities, e, theme, variants }) => {
            const newUtilities = {};
            Object.entries(theme("colors")).map(([name, value]) => {
                if (name === "transparent" || name === "current") return;
                const color = value[300] ? value[300] : value;
                const hsla = Color(color)
                    .alpha(0.45)
                    .hsl()
                    .string();

                newUtilities[`.shadow-outline-${name}`] = {
                    "box-shadow": `0 0 0 3px ${hsla}`
                };
            });

            addUtilities(newUtilities, variants("boxShadow"));
        })
    ]
}
