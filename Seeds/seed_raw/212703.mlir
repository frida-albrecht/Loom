module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<134> : tensor<9xi16>}> : () -> tensor<9xi16>
    %1 = "tosa.const"() <{values = dense<113> : tensor<1xi16>}> : () -> tensor<1xi16>
    %2 = "tosa.const"() <{values = dense<1.382000e+02> : tensor<8x8x10x9xf32>}> : () -> tensor<8x8x10x9xf32>
    %3 = "tosa.const"() <{values = dense<-21> : tensor<i32>}> : () -> tensor<i32>
    %4 = "tosa.const"() <{values = dense<-194> : tensor<i32>}> : () -> tensor<i32>
    %5 = tosa.sub %0, %1 : (tensor<9xi16>, tensor<1xi16>) -> tensor<9xi16>
    %6 = tosa.bitwise_not %5 : (tensor<9xi16>) -> tensor<9xi16>
    %7 = tosa.add %6, %6 : (tensor<9xi16>, tensor<9xi16>) -> tensor<9xi16>
    %8 = tosa.bitwise_or %7, %5 : (tensor<9xi16>, tensor<9xi16>) -> tensor<9xi16>
    %9 = tosa.sub %8, %5 : (tensor<9xi16>, tensor<9xi16>) -> tensor<9xi16>
    %10 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %11 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %12 = tosa.negate %9, %10, %11 : (tensor<9xi16>, tensor<1xi16>, tensor<1xi16>) -> tensor<9xi16>
    %13 = tosa.logical_left_shift %12, %6 : (tensor<9xi16>, tensor<9xi16>) -> tensor<9xi16>
    %14 = tosa.exp %2 : (tensor<8x8x10x9xf32>) -> tensor<8x8x10x9xf32>
    %15 = tosa.concat %13, %13 {axis = 0 : i32} : (tensor<9xi16>, tensor<9xi16>) -> tensor<18xi16>
    %16 = tosa.bitwise_and %15, %15 : (tensor<18xi16>, tensor<18xi16>) -> tensor<18xi16>
    %17 = tosa.intdiv %3, %4 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %18 = "tosa.const"() <{values = dense<[0, 3, 1, 2]> : tensor<4xi32>}> : () -> tensor<4xi32>
    %19 = tosa.transpose %14 {perms = array<i32: 0, 3, 1, 2>} : (tensor<8x8x10x9xf32>) -> tensor<8x9x8x10xf32>
    %cast = tensor.cast %16 : tensor<18xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %17 : tensor<i32> to tensor<*xi32>
    %cast_1 = tensor.cast %19 : tensor<8x9x8x10xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

