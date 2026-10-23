module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-77> : tensor<4x3xi16>}> : () -> tensor<4x3xi16>
    %1 = "tosa.const"() <{values = dense<-7.270000e+00> : tensor<7x9x4xf32>}> : () -> tensor<7x9x4xf32>
    %2 = tosa.identity %0 : (tensor<4x3xi16>) -> tensor<4x3xi16>
    %3 = tosa.sigmoid %1 : (tensor<7x9x4xf32>) -> tensor<7x9x4xf32>
    %4 = tosa.reverse %3 {axis = 1 : i32} : (tensor<7x9x4xf32>) -> tensor<7x9x4xf32>
    %5 = tosa.rsqrt %4 : (tensor<7x9x4xf32>) -> tensor<7x9x4xf32>
    %6 = tosa.identity %4 : (tensor<7x9x4xf32>) -> tensor<7x9x4xf32>
    %cast = tensor.cast %2 : tensor<4x3xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %5 : tensor<7x9x4xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %6 : tensor<7x9x4xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

