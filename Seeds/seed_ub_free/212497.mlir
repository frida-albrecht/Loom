module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-13> : tensor<i32>}> : () -> tensor<i32>
    %1 = "tosa.const"() <{values = dense<154> : tensor<i32>}> : () -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<12> : tensor<9x8xi8>}> : () -> tensor<9x8xi8>
    %3 = "tosa.const"() <{values = dense<6> : tensor<9x8xi8>}> : () -> tensor<9x8xi8>
    %4 = tosa.bitwise_xor %0, %1 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %5 = tosa.minimum %2, %3 : (tensor<9x8xi8>, tensor<9x8xi8>) -> tensor<9x8xi8>
    %6 = tosa.reduce_sum %5 {axis = 0 : i32} : (tensor<9x8xi8>) -> tensor<1x8xi8>
    %7 = tosa.maximum %5, %5 : (tensor<9x8xi8>, tensor<9x8xi8>) -> tensor<9x8xi8>
    %8 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %9 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %10 = tosa.negate %7, %8, %9 : (tensor<9x8xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<9x8xi8>
    %cast = tensor.cast %4 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %6 : tensor<1x8xi8> to tensor<*xi8>
    %cast_1 = tensor.cast %10 : tensor<9x8xi8> to tensor<*xi8>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    call @printMemrefI8(%cast_1) : (tensor<*xi8>) -> ()
    return
  }
}

