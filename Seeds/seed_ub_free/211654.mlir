module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-36> : tensor<4xi16>}> : () -> tensor<4xi16>
    %1 = "tosa.const"() <{values = dense<-4.134000e+01> : tensor<6x6xf32>}> : () -> tensor<6x6xf32>
    %2 = tosa.reduce_min %0 {axis = 0 : i32} : (tensor<4xi16>) -> tensor<1xi16>
    %3 = tosa.rsqrt %1 : (tensor<6x6xf32>) -> tensor<6x6xf32>
    %4 = tosa.minimum %3, %3 : (tensor<6x6xf32>, tensor<6x6xf32>) -> tensor<6x6xf32>
    %5 = tosa.identity %3 : (tensor<6x6xf32>) -> tensor<6x6xf32>
    %cast = tensor.cast %2 : tensor<1xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %4 : tensor<6x6xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %5 : tensor<6x6xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

