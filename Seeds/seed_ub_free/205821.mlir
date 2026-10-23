module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-77> : tensor<7xi16>}> : () -> tensor<7xi16>
    %1 = "tosa.const"() <{values = dense<4.050000e+00> : tensor<3x8xf32>}> : () -> tensor<3x8xf32>
    %2 = tosa.reduce_max %0 {axis = 0 : i32} : (tensor<7xi16>) -> tensor<1xi16>
    %3 = tosa.rsqrt %1 : (tensor<3x8xf32>) -> tensor<3x8xf32>
    %cast = tensor.cast %2 : tensor<1xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %3 : tensor<3x8xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

