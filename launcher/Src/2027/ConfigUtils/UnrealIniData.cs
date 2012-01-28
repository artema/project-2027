using System;
using System.Collections.Generic;
using System.Linq;

namespace ConfigUtils
{
    internal struct SectionPair
    {
        public string Section;
        public string Key;
    }

    internal class UnrealIniData
    {
        private readonly Dictionary<SectionPair, List<string>> _data = new Dictionary<SectionPair, List<string>>();

        public IEnumerable<string> Sections
        {
            get { return (from sectionPair in _data.Keys select sectionPair.Section).Distinct(); }
        }

        #region Public methods
        /// <summary>
        /// Returns the value for the given section, key pair.
        /// </summary>
        /// <param name="sectionName">Section name.</param>
        /// <param name="settingName">Key name.</param>
        /// <exception cref="KeyNotFoundException">Section or setting not found.</exception>
        /// /// <exception cref="InvalidOperationException">Section contains multiple values.</exception>
        public string GetSetting(string sectionName, string settingName)
        {
            if (string.IsNullOrEmpty(sectionName))
                throw new ArgumentException("sectionName");

            if (string.IsNullOrEmpty(settingName))
                throw new ArgumentException("settingName");

            SectionPair sectionPair;
            sectionPair.Section = sectionName;
            sectionPair.Key = settingName;

            return GetSetting(sectionPair);
        }

        /// <summary>
        /// Returns the values for the given section and key pairs.
        /// </summary>
        /// <param name="sectionName">Section name.</param>
        /// <param name="settingName">Key name.</param>
        /// /// <exception cref="KeyNotFoundException">Section or setting not found.</exception>
        public string[] GetMultilineSetting(string sectionName, string settingName)
        {
            if (string.IsNullOrEmpty(sectionName))
                throw new ArgumentException("sectionName");

            if (string.IsNullOrEmpty(settingName))
                throw new ArgumentException("settingName");

            SectionPair sectionPair;
            sectionPair.Section = sectionName;
            sectionPair.Key = settingName;

            return GetMultilineSetting(sectionPair);
        }

        /// <summary>
        /// Set the values for the given section, key pair.
        /// </summary>
        /// <param name="sectionName">Section name.</param>
        /// <param name="settingName">Key name.</param>
        /// <param name="value">New setting value.</param>
        /// /// <exception cref="KeyNotFoundException">Section or setting not found.</exception>
        public void SetSetting(string sectionName, string settingName, string value)
        {
            if (string.IsNullOrEmpty(sectionName))
                throw new ArgumentException("sectionName");

            if (string.IsNullOrEmpty(settingName))
                throw new ArgumentException("settingName");

            if(value == null)
                throw new ArgumentNullException("value");

            SectionPair sectionPair;
            sectionPair.Section = sectionName;
            sectionPair.Key = settingName;

            if (_data[sectionPair].Count > 1)
                throw new InvalidOperationException("Section contains multiple values");

            _data[sectionPair][0] = value;
        }

        /// <summary>
        /// Set the multiline values for the given section, key pair.
        /// </summary>
        /// <param name="sectionName">Section name.</param>
        /// <param name="settingName">Key name.</param>
        /// <param name="values">New values.</param>
        /// /// <exception cref="KeyNotFoundException">Section or setting not found.</exception>
        public void SetMultilineSetting(string sectionName, string settingName, string[] values)
        {
            if (string.IsNullOrEmpty(sectionName))
                throw new ArgumentException("sectionName");

            if (string.IsNullOrEmpty(settingName))
                throw new ArgumentException("settingName");

            if (values == null || values.Length == 0)
                throw new ArgumentNullException("values");

            SectionPair sectionPair;
            sectionPair.Section = sectionName;
            sectionPair.Key = settingName;

            _data[sectionPair] = values.ToList();
        }
        #endregion;

        #region Internal methods
        internal string GetSetting(SectionPair sectionPair)
        {
            var value = _data[sectionPair];

            if (value.Count > 1)
                throw new InvalidOperationException("Section contains multiple values");

            return value[0];
        }

        internal string[] GetMultilineSetting(SectionPair sectionPair)
        {
            return _data[sectionPair].ToArray();
        }

        internal KeyValuePair<string, string>[] GetSectionData(string sectionName)
        {
            var settings = from sectionPair in _data.Keys
                           where sectionPair.Section == sectionName
                           select new KeyValuePair<string, List<string>>(sectionPair.Key, _data[sectionPair]);

            return (from tuple in settings 
                    from item in tuple.Value
                    select new KeyValuePair<string, string>(tuple.Key, item)
                    ).ToArray();
        }

        internal void AddSetting(SectionPair sectionPair, string sectionValue)
        {
            if (!_data.ContainsKey(sectionPair))
                _data.Add(sectionPair, new List<string> { sectionValue });
            else
                _data[sectionPair].Add(sectionValue);
        }
        #endregion;
    }
}
