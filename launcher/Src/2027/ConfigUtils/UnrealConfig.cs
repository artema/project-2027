using System;
using System.Collections.Generic;
using System.IO;

namespace ConfigUtils
{
    /// <summary>
    /// Unreal INI config.
    /// </summary>
    public class UnrealConfig
    {
        private readonly UnrealIniData _data;

        private readonly string _iniPath;

        public UnrealConfig(string iniPath)
        {
            if (string.IsNullOrEmpty(iniPath))
                throw new ArgumentException("iniPath");

            _iniPath = iniPath;

            if (File.Exists(_iniPath))
            {
                using(var stream = new FileStream(_iniPath, FileMode.Open))
                {
                    _data = new UnrealIniParser(stream).Data;
                }
            }
            else
                throw new FileNotFoundException("Unable to locate " + _iniPath);
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
            return _data.GetSetting(sectionName, settingName);
        }

        /// <summary>
        /// Returns the values for the given section and key pairs.
        /// </summary>
        /// <param name="sectionName">Section name.</param>
        /// <param name="settingName">Key name.</param>
        /// /// <exception cref="KeyNotFoundException">Section or setting not found.</exception>
        public string[] GetMultilineSetting(string sectionName, string settingName)
        {
            return _data.GetMultilineSetting(sectionName, settingName);
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
            _data.SetSetting(sectionName, settingName, value);
        }

        /// <summary>
        /// Set the multiline values for the given section, key pair.
        /// </summary>
        /// <param name="sectionName">Section name.</param>
        /// <param name="settingName">Key name.</param>
        /// <param name="values">New setting values.</param>
        /// /// <exception cref="KeyNotFoundException">Section or setting not found.</exception>
        public void SetMultilineSetting(string sectionName, string settingName, string[] values)
        {
            _data.SetMultilineSetting(sectionName, settingName, values);
        }

        /// <summary>
        /// Save changes to the config file.
        /// </summary>
        public void Save()
        {
            using(var writer = new StreamWriter(_iniPath))
            {
                writer.Write(new UnrealIniWriter(_data).WriteData());
            }
        }
        #endregion;
    }
}
