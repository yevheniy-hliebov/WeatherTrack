export const customStyles = {
    control: (provided, state) => ({
        ...provided,
        borderRadius: '10px',
        border: '0px solid transparent',
        outline: state.isFocused ? '#f4f4f4 solid 1px' : null,
        background: "linear-gradient(135deg, rgba(255, 255, 255, 0.40) 0%, rgba(255, 255, 255, 0.10) 100%)",
        backdropFilter: "blur(20px)",
        boxShadow: null,
    }),
    placeholder: (provided, state) => ({
        ...provided,
        color: "#f4f4f4",
    }),
    input: (provided, state) => ({
        ...provided,
        color: "#f4f4f4",
    }),
    menu: (provided, state) => ({
        ...provided,
        borderRadius: '10px',
        border: '0px solid transparent',
        outline: state.isFocused ? '#f4f4f4 solid 1px' : null,
        background: "linear-gradient(135deg, rgba(255, 255, 255, 0.40) 0%, rgba(255, 255, 255, 0.10) 100%)",
        backdropFilter: "blur(20px)",
        boxShadow: null,
    }),
    option: (provided, state) => ({
        ...provided,
        borderRadius: '10px',
        backgroundColor: state.isFocused ? '#f4f4f4' : null,
        color: state.isFocused ? '#272727' : '#f4f4f4',
    }),
}