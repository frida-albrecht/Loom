module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-7.059000e+01> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<-34> : tensor<3xi16>}> : () -> tensor<3xi16>
    %2 = tosa.log %0 : (tensor<f32>) -> tensor<f32>
    %3 = tosa.reduce_max %1 {axis = 0 : i32} : (tensor<3xi16>) -> tensor<1xi16>
    %cast = tensor.cast %2 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %3 : tensor<1xi16> to tensor<*xi16>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}

