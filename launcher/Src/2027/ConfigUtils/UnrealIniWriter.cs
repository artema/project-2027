using System;
using System.Text;

namespace ConfigUtils
{
    internal class UnrealIniWriter
    {
        private readonly UnrealIniData _data = new UnrealIniData();

        public UnrealIniWriter(UnrealIniData data)
        {
            if(data == null)
                throw new ArgumentNullException("data");

            _data = data;
        }

        public string WriteData()
        {
            var text = new StringBuilder();

            foreach (var section in _data.Sections)
            {
                text.Append(UnrealIniSyntax.SectionFirstCharacter)
                    .Append(section)
                    .Append(UnrealIniSyntax.SectionLastCharacter)
                    .Append(UnrealIniSyntax.NewLineSymbols);

                foreach (var pair in _data.GetSectionData(section))
                {
                    text.Append(pair.Key)
                        .Append(UnrealIniSyntax.KeyValuePairDelimeter)
                        .Append(pair.Value)
                        .Append(UnrealIniSyntax.NewLineSymbols);
                }

                text.Append(UnrealIniSyntax.NewLineSymbols);
            }

            return text.ToString();
        }
    }
}
