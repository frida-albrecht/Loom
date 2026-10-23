module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-6> : tensor<7x2x9x1xi8>}> : () -> tensor<7x2x9x1xi8>
    %1 = "tosa.const"() <{values = dense<1.350500e+02> : tensor<4x8xf32>}> : () -> tensor<4x8xf32>
    %2 = tosa.reverse %0 {axis = 3 : i32} : (tensor<7x2x9x1xi8>) -> tensor<7x2x9x1xi8>
    %3 = tosa.bitwise_not %2 : (tensor<7x2x9x1xi8>) -> tensor<7x2x9x1xi8>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %6 = tosa.negate %3, %4, %5 : (tensor<7x2x9x1xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<7x2x9x1xi8>
    %7 = tosa.reciprocal %1 : (tensor<4x8xf32>) -> tensor<4x8xf32>
    %8 = tosa.reduce_min %6 {axis = 2 : i32} : (tensor<7x2x9x1xi8>) -> tensor<7x2x1x1xi8>
    %9 = tosa.sub %8, %8 : (tensor<7x2x1x1xi8>, tensor<7x2x1x1xi8>) -> tensor<7x2x1x1xi8>
    %cast = tensor.cast %7 : tensor<4x8xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %9 : tensor<7x2x1x1xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

