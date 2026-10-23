module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<167> : tensor<4x10x5x5xi16>}> : () -> tensor<4x10x5x5xi16>
    %1 = "tosa.const"() <{values = dense<-109> : tensor<1x1x1x1xi16>}> : () -> tensor<1x1x1x1xi16>
    %2 = "tosa.const"() <{values = dense<1.753600e+02> : tensor<10x5xf32>}> : () -> tensor<10x5xf32>
    %3 = tosa.bitwise_xor %0, %1 : (tensor<4x10x5x5xi16>, tensor<1x1x1x1xi16>) -> tensor<4x10x5x5xi16>
    %4 = tosa.tanh %2 : (tensor<10x5xf32>) -> tensor<10x5xf32>
    %5 = tosa.reverse %4 {axis = 1 : i32} : (tensor<10x5xf32>) -> tensor<10x5xf32>
    %cast = tensor.cast %3 : tensor<4x10x5x5xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %5 : tensor<10x5xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

