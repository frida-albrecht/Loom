module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-136> : tensor<5xi16>}> : () -> tensor<5xi16>
    %1 = "tosa.const"() <{values = dense<-2> : tensor<5xi16>}> : () -> tensor<5xi16>
    %2 = "tosa.const"() <{values = dense<1.297000e+01> : tensor<3x2xf32>}> : () -> tensor<3x2xf32>
    %3 = tosa.bitwise_xor %0, %1 : (tensor<5xi16>, tensor<5xi16>) -> tensor<5xi16>
    %4 = tosa.floor %2 : (tensor<3x2xf32>) -> tensor<3x2xf32>
    %5 = tosa.reduce_max %3 {axis = 0 : i32} : (tensor<5xi16>) -> tensor<1xi16>
    %6 = tosa.abs %4 : (tensor<3x2xf32>) -> tensor<3x2xf32>
    %7 = tosa.identity %6 : (tensor<3x2xf32>) -> tensor<3x2xf32>
    %cast = tensor.cast %5 : tensor<1xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %7 : tensor<3x2xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

