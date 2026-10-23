module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.429100e+02> : tensor<5xf32>}> : () -> tensor<5xf32>
    %1 = "tosa.const"() <{values = dense<104> : tensor<8x2xi16>}> : () -> tensor<8x2xi16>
    %2 = tosa.reciprocal %0 : (tensor<5xf32>) -> tensor<5xf32>
    %3 = tosa.reduce_min %2 {axis = 0 : i32} : (tensor<5xf32>) -> tensor<1xf32>
    %4 = tosa.clz %1 : (tensor<8x2xi16>) -> tensor<8x2xi16>
    %cast = tensor.cast %3 : tensor<1xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %4 : tensor<8x2xi16> to tensor<*xi16>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}

