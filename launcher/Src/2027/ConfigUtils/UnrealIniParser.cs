using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace ConfigUtils
{
    internal class UnrealIniParser
    {
        private readonly UnrealIniData _data = new UnrealIniData();

        #region Initialization
        /// <summary>
        /// Reads Unreal INI from a stream.
        /// </summary>
        /// <param name="stream">Stream that contains INI file data.</param>
        public UnrealIniParser(Stream stream)
        {
            if (stream == null)
                throw new ArgumentNullException("stream");

            if (!stream.CanRead)
                throw new ArgumentException("Invalid stream", "stream");

            using (var reader = new StreamReader(stream))
            {
                ReadStream(reader);
            }
        }
        #endregion;

        #region Public properties
        /// <summary>
        /// Parsed content.
        /// </summary>
        internal UnrealIniData Data
        {
            get { return _data; }
        }
        #endregion;

        #region Parser implementation
        private void ReadStream(TextReader reader)
        {
            var currentSectionName = UnrealIniSyntax.DefaultSectionName;

            string line;

            while ((line = reader.ReadLine()) != null)
            {
                line = line.Trim();

                if (line != string.Empty)
                {
                    if (line.StartsWith(UnrealIniSyntax.SectionFirstCharacter) && line.EndsWith(UnrealIniSyntax.SectionLastCharacter)) //Section header
                    {
                        currentSectionName = line.Substring(1, line.Length - 2);
                    }
                    else //Key-value pair
                    {
                        var tuple = ReadSectionPair(line, currentSectionName);
                        _data.AddSetting(tuple.Key, tuple.Value);
                    }
                }
            }
        }

        private KeyValuePair<SectionPair, string> ReadSectionPair(string line, string sectionName)
        {
            var pair = line.Split(new[] { UnrealIniSyntax.KeyValuePairDelimeter }, 2);

            string value = null;

            var sectionPair = new SectionPair { Section = sectionName, Key = pair[0] };

            if (pair.Length > 1)
                value = pair[1];

            return new KeyValuePair<SectionPair, string>(sectionPair, value);
        }
        #endregion;
    }
}
