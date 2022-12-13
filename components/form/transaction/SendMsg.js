import { useState } from "react";
import Input from "../../input/Input"
import { isValidAddress } from "../../../libs/checkTool";
import { openNotification } from "../../ulti/Notification";
import { createSendMsg, } from "../../../libs/transaction";
import { convertValueFromDenom } from "../../../libs/stringConvert";
import Button from "../../input/Button";

const SendMsgForm = ({ address, chain, style, msgs, setMsgs }) => {
    const [txBody, setTxBody] = useState({
      toAddress: '',
      amount: 0,
      denom: ''
    });
    const [addrError, setAddrError] = useState("")

  const invalidForm = () => {
    for (let key in txBody) {
      if (key === 'amount' && txBody[key] === 0) return true;
    }
    return false;
  };

  const disabled = () => {
    if (invalidForm() || addrError !== '') {
      return true;
    }
    return false;
  };

  const createMsg = () => {
    try {
      const msg = createSendMsg(
        address,
        txBody.toAddress,
        convertValueFromDenom(chain.base_denom.exponent, txBody.amount),
        txBody.denom
      );
      setMsgs([...msgs, msg]);
      openNotification('success', 'Adding successfully');
    } catch (e) {
      openNotification('error', 'Adding unsuccessfully');
    }
  };

  const handleKeyGroupChange = e => {
    if (e.target.name === 'amount') {

      let amount  = parseFloat(e.target.value)*chain?.currencies[e.target.value].coinDecimals
      setTxBody({
        ...txBody,
        [e.target.name]: amount
      });
    } else if (e.target.name === 'denom') {


      console.log('target value support',chain?.currencies[e.target.value]);
      setTxBody({
        ...txBody,
        [e.target.name]: chain?.currencies[e.target.value].coinMinimalDenom
      });
    } else {
      setTxBody({
        ...txBody,
        [e.target.name]: e.target.value
      });
    }
  };

  const handleKeyBlur = e => {
    if (
      e.target.name === 'toAddress' &&
      !isValidAddress(e.target.value, chain.prefix)
    ) {
      setAddrError('Invalid Address');
    } else {
      setAddrError('');
    }
  };

  return (
    <div>
      <Input
        onChange={e => {
          handleKeyGroupChange(e);
        }}
        value={txBody.toAddress}
        label="Send To"
        name="toAddress"
        placeholder="Address here"
        error={addrError}
        onBlur={handleKeyBlur}
        style={style.input}
      />
      <h4
        style={{
          marginBottom: 0
        }}
      >
        Denom
      </h4>
      <select
        defaultValue={0}
        placeholder={'Select message type'}
        name={'denom'}
        onChange={e => {
          handleKeyGroupChange(e);
        }}
        style={{
          marginBottom: '10px',
          width: '100%',
          borderRadius: '10px',
          padding: '1em'
        }}
      >
        {chain?.currencies?.map((data, index) => {
          return (
            <option
              key={index}
              value={index}
              style={{
                padding: '1em',
                color: 'black'
              }}
            >
              {data.coinDenom}
            </option>
          );
        })}
      </select>
      <Input
        onChange={e => {
          handleKeyGroupChange(e);
        }}
        value={txBody.amount}
        label={`Amount`}
        name="amount"
        type="number"
        placeholder="Amount"
        style={style.input}
      />
      <Button
        text={'Add Message'}
        style={{
          backgroundColor: disabled() ? '#808080' : 'black',
          color: 'white',
          padding: '1em',
          width: '100%',
          borderRadius: '10px',
          marginTop: '20px',
          border: 0
        }}
        clickFunction={createMsg}
        disable={disabled()}
      />
    </div>
  );
};

export default SendMsgForm;
