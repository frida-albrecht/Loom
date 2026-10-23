module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<5> : tensor<i8>}> : () -> tensor<i8>
    %1 = "tosa.const"() <{values = dense<-13> : tensor<8x2x2xi8>}> : () -> tensor<8x2x2xi8>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = tosa.negate %0, %2, %3 : (tensor<i8>, tensor<1xi8>, tensor<1xi8>) -> tensor<i8>
    %5 = tosa.add %4, %4 : (tensor<i8>, tensor<i8>) -> tensor<i8>
    %6 = "tosa.const"() <{values = dense<[0, 2, 1]> : tensor<3xi32>}> : () -> tensor<3xi32>
    %7 = tosa.transpose %1 {perms = array<i32: 0, 1, 2>} : (tensor<8x2x2xi8>) -> tensor<8x2x2xi8>
    %cast = tensor.cast %5 : tensor<i8> to tensor<*xi8>
    %cast_0 = tensor.cast %7 : tensor<8x2x2xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

