module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<19> : tensor<9x1xi8>}> : () -> tensor<9x1xi8>
    %1 = "tosa.const"() <{values = dense<-1.842700e+02> : tensor<3xf32>}> : () -> tensor<3xf32>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = tosa.negate %0, %2, %3 : (tensor<9x1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<9x1xi8>
    %5 = tosa.log %1 : (tensor<3xf32>) -> tensor<3xf32>
    %6 = tosa.reduce_min %5 {axis = 0 : i32} : (tensor<3xf32>) -> tensor<1xf32>
    %cast = tensor.cast %4 : tensor<9x1xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %6 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

