module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.218100e+02> : tensor<8xf32>}> : () -> tensor<8xf32>
    %1 = "tosa.const"() <{values = dense<52> : tensor<i16>}> : () -> tensor<i16>
    %2 = "tosa.const"() <{values = dense<-196> : tensor<i16>}> : () -> tensor<i16>
    %3 = tosa.tanh %0 : (tensor<8xf32>) -> tensor<8xf32>
    %4 = tosa.bitwise_xor %1, %2 : (tensor<i16>, tensor<i16>) -> tensor<i16>
    %cast = tensor.cast %3 : tensor<8xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %4 : tensor<i16> to tensor<*xi16>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}

